import json
import re
from decimal import Decimal
from collections import namedtuple

TITLE_REGEX = re.compile(r'(.*) \((.* Deanery)\)')
SCALE = 1000

Point = namedtuple('Point', ['x', 'y'])
Coordinate = namedtuple('Coordinate', ['lon', 'lat'])

"""
Notes on map projections:

https://en.wikipedia.org/wiki/Transverse_Mercator_projection 
https://en.wikipedia.org/wiki/Map_projection#Conformal

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
    
    def add(self, parish):
        self.parishes.append(parish)
    
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
    
    def projection(self, scale=1000):
        min_lat, min_lon = self.min_lat, self.min_lon
        delta_lat = self.max_lat - self.min_lat
        delta_lon = self.max_lon - self.min_lon
        lat_over_lon_ratio = delta_lat / delta_lon

        print('Map area spans: lon {}, lat {}, lat/lon {}'.format(
            delta_lon, delta_lat, lat_over_lon_ratio))

        q_scale = Decimal('0.001')

        return lambda coord: Point(
            ((coord.lon - min_lon) * scale / delta_lon * lat_over_lon_ratio).quantize(q_scale),
            ((coord.lat - min_lat) * scale / delta_lat).quantize(q_scale),
        )
    
    def all_points(self):
        projection = self.projection(1000)
        for p in self.parishes:
            for point in p.points(projection):
                yield point

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
        self.title = data['title']
        m = TITLE_REGEX.match(self.title)
        if m:
            self.name = m.group(1)
            self.deanery = m.group(2)
        print('{} - {}'.format(self.name, self.deanery))
        self.coords = [point_strings_to_decimals(point) for point in self.data['polydata']]
        print(self.coords[0])
        print()
        # print(self.data.keys())
        self.max_lat = max([coord.lat for coord in self.coords])
        self.max_lon = max([coord.lon for coord in self.coords])
        self.min_lat = min([coord.lat for coord in self.coords])
        self.min_lon = min([coord.lon for coord in self.coords])
    
    def points(self, projection=None):
        if projection is None:
            projection = lambda lat, lon: (lat, lon)
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
    print()
    corners = find_corners(list(m.all_points()))
    print('Corners: {}'.format(corners))

if __name__ == '__main__':
    main()
