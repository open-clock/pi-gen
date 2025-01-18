from waveshare_epd import epd7in5_V2
from PIL import Image
import os

if os.path.exists("/displaydriver/skipshutdown"):
    exit()

epd = epd7in5_V2.EPD()

epd.init_fast()
Limage = Image.open("/displaydriver/shutdown.png")
epd.display(epd.getbuffer(Limage))
epd.sleep()