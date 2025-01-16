from waveshare_epd import epd7in5_V2
from PIL import Image

epd = epd7in5_V2.EPD()

epd.init()
Limage = Image.open("boot.png")
epd.display(epd.getbuffer(Limage))
epd.sleep()