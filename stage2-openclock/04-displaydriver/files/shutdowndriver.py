from waveshare_epd import epd7in5_V2

epd = epd7in5_V2.EPD()

#epd.init()
#Limage = Image.open("shutdown.png")
#epd.display(epd.getbuffer(Limage))
#time.sleep(2)
epd.init()
epd.Clear()
epd.sleep()