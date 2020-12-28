From: Robert Delien <r.delien@payter.nl>
To: op-tee@lists.trustedfirmware.org
Subject: Mapping an arbitrary SDRAM block outside TZDRAM
Date: Mon, 28 Dec 2020 19:48:45 +0100
Message-ID: 
 <CAEhEOQm38Qi9JXDnpZ+b=qWNZSz2Vw5wTdvvnDwxhMCbxyrRaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6990739152865706590=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6990739152865706590==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

As discussed earlier, our application requires secured display contents and
is using a secure frame buffer.

Now to transit from U-Boot to Op-tee as smoothly as possible, I would like
to copy the contents from the U-Boot frame buffer into the Optee frame
buffer upon LCD driver initialisation.

The U-Boot frame buffer address is calculated at run time and I haven't
found a hand-off mechanism, but the physical address can be easily read
from the LCDIF peripheral's registers. Unfortunately, no MMU mapping is
present per default for this physical address outside the TZDRAM area.

Is it possible to temporarily map this rather arbitrary non-secure physical
DDR address outside TZDRAM, so I can access it through a virtual address?
Preferably in a way that I can also remove this mapping after copying the
frame buffer?

Thanks in advance; Your help is highly appreciated.

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

--===============6990739152865706590==--

