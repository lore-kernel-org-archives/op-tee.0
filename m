From: Robert Delien <r.delien@payter.nl>
To: op-tee@lists.trustedfirmware.org
Subject: Possible OB1 bug in imx_csu.c
Date: Mon, 22 Feb 2021 11:01:13 +0100
Message-ID: 
 <CAEhEOQ=GHavi7nOkYn0ov7tWrHoGJ=B4AG_6nSqWBytBQ7RQ=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3211609870354104289=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3211609870354104289==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

In imx_csu.c, the Central Security Unit's CSU_CSL*n* registers are set,
configuring access privileges for different peripherals. These registers
range from CSU_CSL0 (@ 0x021c0000) to CSU_CSL39 (@ 0x021c009c).

The different i.MX6 platform variants each have their individual tables,
filled with sets of CSL index and register value, terminated by a sentinel
set with the index set to -1. (the reason for the parentheses around -1
espaces me)

in .../core/arch/arm/plat-imx/drivers/imx_csu.c:csu_init()@115, a while
loop runs through this aforementioned table, setting the CSL registers
according to the table. However, this loop loops on CSL index values > 0:
while (csu_setting->csu_index *>* 0) {
        io_write32(csu_base + (csu_setting->csu_index * 4),
                   csu_setting->value);

        csu_setting++;
}
I think it should loop on CSL index values >= 0, because index 0 is a valid
index, utilized for the PWM peripherals. (I also think csl_index is a more
descriptive name, but that's besides the point).

I have attached a patch for his.

With kind regards,

          Robert.

-- 
DISCLAIMER
De informatie, verzonden in of met dit e-mailbericht, is 
vertrouwelijk en uitsluitend voor de geadresseerde(n) bestemd. Het gebruik 
van de informatie in dit bericht, de openbaarmaking, vermenigvuldiging, 
verspreiding en|of verstrekking daarvan aan derden is niet toegestaan. 
Gebruik van deze informatie door anderen dan geadresseerde(n) is strikt 
verboden. Aan deze informatie kunnen geen rechten worden ontleend. U wordt 
verzocht bij onjuiste adressering de afzender direct te informeren door het 
bericht te retourneren en het bericht uit uw computersysteem te verwijderen.

--===============3211609870354104289==--

