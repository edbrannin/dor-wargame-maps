from to_svg import Point

def test_point_round():
    p = Point(123.4, 234.4)
    rounded = p.round()
    assert rounded.x == 123
    assert rounded.y == 234

def test_point_round_2():
    p = Point(123.4, 234.7)
    rounded = p.round()
    assert rounded.x == 123
    assert rounded.y == 235
