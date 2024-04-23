From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 23 Apr 2024 09:29:00 +0200
Message-ID: 
 <CAHUa44EzMpRbhJ=-h4hJifgtrMsvDZj=Zt4C3JkDxjKE4gz=7A@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CDM6PR04MB6575CE5A70F2C733DF40E54CFC112=40DM6PR04MB?=
 =?utf-8?q?6575=2Enamprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8722153931644191633=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8722153931644191633==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, Apr 23, 2024 at 8:42 AM Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > The OP-TEE driver finds the correct RPMB device to interact with by
> > iterating over available devices until one is found with a programmed
> > authentication matching the one OP-TEE is using. This enables coexisting
> > users of other RPMBs since the owner can be determined by who knows the
> > authentication key.
> Devices in plural?
> I am unaware of any board with multi eMMC devices soldered.
> Can you refer me to such a platform?

I'm testing with a Hikey960 (HiSilicon Kirin 620)
https://www.96boards.org/product/hikey
It has one soldered eMMC and one removable eMMC.

Cheers,
Jens

--===============8722153931644191633==--

