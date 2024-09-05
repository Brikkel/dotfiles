#!/usr/bin/env python3
#
# Copyright (C) 2016 James Murphy
# Licensed under the GPL version 2 only
#
# A battery indicator blocklet script for i3blocks

from subprocess import check_output
import os
import re

config = dict(os.environ)
status = check_output(['acpi'], universal_newlines=True)

if not status:
    # stands for no battery found
    color = config.get("color_10", "red")
    fulltext = "<span color='{}'><span font='FontAwesome'>\uf00d \uf240</span></span>".format(color)
    percentleft = 100
else:
    # if there is more than one battery in one laptop, the percentage left is
    # available for each battery separately, although state and remaining
    # time for overall block is shown in the status of the first battery
    batteries = status.split("\n")
    state_batteries=[]
    commasplitstatus_batteries=[]
    percentleft_batteries=[]
    time = ""
    for battery in batteries:
        if battery!='':
            state_batteries.append(battery.split(": ")[1].split(", ")[0])
            commasplitstatus = battery.split(", ")
            if not time:
                time = commasplitstatus[-1].strip()
                # check if it matches a time
                time = re.match(r"(\d+):(\d+)", time)
                if time:
                    time = ":".join(time.groups())
                    timeleft = " ({})".format(time)
                else:
                    timeleft = ""

            p = int(commasplitstatus[1].rstrip("%\n"))
            if p>0:
                percentleft_batteries.append(p)
            commasplitstatus_batteries.append(commasplitstatus)
    state = state_batteries[0]
    commasplitstatus = commasplitstatus_batteries[0]
    if percentleft_batteries:
        percentleft = int(sum(percentleft_batteries)/len(percentleft_batteries))
    else:
        percentleft = 0

    # Define the font family for 0xProto Nerd Font
    nerd_font_family = "0xProto Nerd Font"

    # Define the FontAwesome icons with the appropriate font family for Nerd Font
    FA_LIGHTNING = f"<span font='{nerd_font_family}'>\uf0e7 </span>"
    FA_PLUG = f"<span font='{nerd_font_family}'>\uf1e6 </span>"
    FA_BATTERY_FULL = f"<span font='{nerd_font_family}'>\uf240 </span>"
    FA_BATTERY_THREEQ = f"<span font='{nerd_font_family}'>\uf241 </span>"
    FA_BATTERY_HALF = f"<span font='{nerd_font_family}'>\uf242 </span>"
    FA_BATTERY_ONEQ = f"<span font='{nerd_font_family}'>\uf243 </span>"
    FA_BATTERY_EMPTY = f"<span font='{nerd_font_family}'>\uf244 </span>"
    FA_QUESTION = f"<span font='{nerd_font_family}'>\uf128 </span>"



    def get_icon(chr_state, percent):
        if chr_state == "Discharging":
            if percent < 10:
                return FA_BATTERY_EMPTY
            elif percent < 26:
                return FA_BATTERY_ONEQ
            elif percent < 51:
                return FA_BATTERY_HALF
            elif percent < 76:
                return FA_BATTERY_THREEQ
            else:
                return FA_BATTERY_FULL
        elif chr_state == "Full":
            return FA_PLUG
            timeleft = ""
        elif chr_state == "Unknown":
            return FA_QUESTION
        return FA_LIGHTNING
    
    fulltext = get_icon(state, percentleft) + " " 

    form =  '<span color="{}">{}%</span>'
    fulltext += form.format(config.get("color_full", "#FFFFFF"), percentleft)
#    fulltext += timeleft

print(fulltext)
print(fulltext)
if percentleft < 10:
    exit(33)
