import json
import re
from decimal import Decimal
from collections import namedtuple, defaultdict

import svgwrite

TITLE_REGEX = re.compile(r'(.*) \((.* Deanery)\)')
SCALE = 8000

Point = namedtuple('Point', ['x', 'y'])
Point.round = lambda point: Point(round(point.x), round(point.y))

Coordinate = namedtuple('Coordinate', ['lon', 'lat'])

def slug(text):
    return re.sub(r'[^a-zA-Z]+', '-', text)

"""
Notes on map projections:

https://en.wikipedia.org/wiki/Transverse_Mercator_projection 
https://en.wikipedia.org/wiki/Map_projection#Conformal

On label placement:
https://en.wikipedia.org/wiki/Centroid#Of_a_polygon
https://math.stackexchange.com/questions/90463/how-can-i-calculate-the-centroid-of-polygon
https://math.stackexchange.com/questions/1801867/finding-the-centre-of-an-abritary-set-of-points-in-two-dimensions
https://math.stackexchange.com/questions/3177/why-doesnt-a-simple-mean-give-the-position-of-a-centroid-in-a-polygon
"""

def point_strings_to_decimals(point):
    return Coordinate(
        lat=Decimal(point[0]),
        lon=Decimal(point[1]),
    )

def find_corners(points):
    min_x = max_x = points[0].x
    min_y = max_y = points[0].y
    for p in points:
        if min_x > p.x:
            min_x = p.x
        if min_y > p.y:
            min_y = p.y
        if max_x < p.x:
            max_x = p.x
        if max_y < p.y:
            max_y = p.y
    return (Point(min_x, min_y), Point(max_x, max_y))

class Map(object):
    def __init__(self):
        self.parishes = []
        self.deaneries = defaultdict(list)
    
    def add(self, parish):
        self.parishes.append(parish)
        self.deaneries[parish.deanery].append(parish)
    
    def combine_deanery(self, deanery):
        parishes = self.deaneries[deanery]
        all_points = set()
        duplicate_points = set()
        for p in parishes:
            for point in p.points(self.projection()):
                if point in all_points:
                    duplicate_points.add(point)
                all_points.add(point)
        print('Checked {} points, found {} duplicates'.format(len(all_points), len(duplicate_points)))
        # Figure out correct outline

    @property
    def max_lat(self):
        return max([p.max_lat for p in self.parishes])

    @property
    def max_lon(self):
        return max([p.max_lon for p in self.parishes])

    @property
    def min_lat(self):
        return min([p.min_lat for p in self.parishes])

    @property
    def min_lon(self):
        return min([p.min_lon for p in self.parishes])
    
    def projection(self, scale=SCALE):
        min_lat, min_lon = self.min_lat, self.min_lon
        delta_lat = self.max_lat - self.min_lat
        delta_lon = self.max_lon - self.min_lon
        lat_over_lon_ratio = delta_lat / delta_lon

        print('Map area spans: lon {}, lat {}, lat/lon {}'.format(
            delta_lon, delta_lat, lat_over_lon_ratio))

        q_scale = Decimal('0.001')

        return lambda coord: Point(
            ((coord.lon - min_lon) * scale / delta_lon * lat_over_lon_ratio).quantize(q_scale),
            ((coord.lat - min_lat) * -scale / delta_lat).quantize(q_scale),
        ).round()
    
    def all_points(self):
        projection = self.projection()
        for p in self.parishes:
            for point in p.points(projection):
                yield point

    def drawing(self):
        svg = svgwrite.Drawing()
        projection = self.projection()
        deaneries = defaultdict(list)
        for deanery, parishes in self.deaneries.items():
            group = svg.g(id=slug(deanery))
            for p in parishes:
                print('Drawing {}'.format(p.title))
                path = svg.path('M', id=slug(p.name),
                                stroke="black", stroke_width="1", fill="#{}".format(p.data["fillcolor"]))
                points = p.points(projection)
                for point in points:
                    path.push(point)
                group.add(path)
            svg.add(group)
        labels = svg.g(id='labels')
        print('Adding labels')
        for deanery, parishes in self.deaneries.items():
            group = svg.g(id='Label-{}'.format(slug(deanery)))
            for p in parishes:
                label = svg.text(p.name, p.center(projection),
                                 id=slug(p.name), fill="black",
                                 text_anchor="middle")
                group.add(label)
            labels.add(group)
        svg.add(labels)
        return svg

class Parish(object):
    """
    [
        "fillcolor",
        "id",
        "innerpolydata",
        "linecolor",
        "lineopacity",
        "link",
        "map_id",
        "ohfillcolor",
        "ohlinecolor",
        "ohopacity",
        "opacity",
        "polydata",
        "polyname",
        "title"
    ]
    """

    def __init__(self, data):
        self.data = data
        self.title = data['title'].replace('\&#039;', "'")
        self.name, self.deanery = re.match(r'(.*) \((.* Deanery)\)', self.title).groups()
        m = TITLE_REGEX.match(self.title)
        if m:
            self.name = m.group(1)
            self.deanery = m.group(2)
        print('Parish {} is in Deanery {}'.format(self.name, self.deanery))
        self.coords = [point_strings_to_decimals(point) for point in self.data['polydata']]
        # print(self.data.keys())
        self.max_lat = max([coord.lat for coord in self.coords])
        self.max_lon = max([coord.lon for coord in self.coords])
        self.min_lat = min([coord.lat for coord in self.coords])
        self.min_lon = min([coord.lon for coord in self.coords])
        print('Bounding box: ({}, {}) - ({}, {})'.format(self.max_lat, self.max_lon, self.min_lat, self.min_lon))
        print('Center: {}'.format(self.center()))
        print('')
    
    def center(self, projection=None):
        "Return the center of this parish's bounding box"
        if projection is None:
            projection = lambda x: x
        return projection(Coordinate(
            self.min_lon + ((self.max_lon - self.min_lon) / 2),
            self.min_lat + ((self.max_lat - self.min_lat) / 2),
            ))
    
    def points(self, projection=None):
        if projection is None:
            projection = lambda x: x
        return [projection(coord) for coord in self.coords]

def load_parishes():
    m = Map()
    with open('parishes.json') as infile:
        data = json.load(infile)
        for item in data["1"].values():
            if item["title"] == 'X':
                continue
            p = Parish(item)
            m.add(p)
    return m

def main():
    m = load_parishes()
    print('Min (lat, lon) = ({}, {})'.format(m.min_lat, m.min_lon))
    print('Max (lat, lon) = ({}, {})'.format(m.max_lat, m.max_lon))
    print('')
    corners = find_corners(list(m.all_points()))
    print('Corners: {}'.format(corners))
    print('')
    print('Deaneries found:')
    for deanery_name in m.deaneries.keys():
        print('- {}'.format(deanery_name))
    # m.combine_deanery('Monroe Central Deanery')
    filename = 'map.svg'
    with open(filename, 'w') as outfile:
        svg_text = m.drawing().tostring()
        outfile.write(svg_text)
        print('Wrote {} bytes to {}'.format(len(svg_text), filename))

if __name__ == '__main__':
    main()

# TODO
# Combine Monroe deaneries:
# Monroe Central Deanery
# Monroe East Deanery
# Monroe West Deanery
