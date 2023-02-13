From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXT] Re: [PATCH v2 1/1] tee: new ioctl to a register tee_shm
 from a dmabuf file descriptor
Date: Mon, 13 Feb 2023 16:22:26 +0100
Message-ID: 
 <CAHUa44G9XhOMfiQ4TpiQWAKSXodG09ivarcYYjS3eg254xcavA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPA4PR04MB752097BD63A2151DC5658D4688DD9=40PA4PR04MB?=
 =?utf-8?q?7520=2Eeurprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7906049357436756153=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7906049357436756153==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Cyrille,

On Mon, Feb 13, 2023 at 1:41 PM Cyrille Fleury <cyrille.fleury@nxp.com> wro=
te:
>
> Hi,
>
> >>
> >>
> >> -----Original Message-----
> >> From: Jerome Forissier <jerome.forissier@linaro.org>
> >> Sent: Friday, February 3, 2023 1:32 PM
> >> To: Etienne Carriere <etienne.carriere@linaro.org>; Olivier Masse
> >> <olivier.masse@nxp.com>
> >> Cc: sumit.garg(a)linaro.org; linux-media(a)vger.kernel.org;
> >> fredgc(a)google.com; linaro-mm-sig(a)lists.linaro.org; afd(a)ti.com;
> >> op-tee(a)lists.trustedfirmware.org; jens.wiklander(a)linaro.org;
> >> joakim.bech(a)linaro.org; sumit.semwal(a)linaro.org; Cyrille Fleury
> >> <cyrille.fleury@nxp.com>; Peter Griffin <peter.griffin@linaro.org>;
> >> linux-kernel(a)vger.kernel.org; dri-devel(a)lists.freedesktop.org; Cl=C3=
=A9ment
> >> Faure <clement.faure@nxp.com>; christian.koenig(a)amd.com
> >> Subject: Re: [EXT] Re: [PATCH v2 1/1] tee: new ioctl to a register
> >> tee_shm from a dmabuf file descriptor
> >>
> >> On 2/3/23 15:12, Cyrille Fleury wrote:
> >> Hi all,
> >>
> >> >On 2/3/23 12:37, Etienne Carriere wrote:
> >> >> Hell all,
> >> >>
> >> >> +jerome f.
> >> >>
> >> >> On Fri, 3 Feb 2023 at 12:01, Olivier Masse <olivier.masse@nxp.com> =
wrote:
> >> >>>
> >> >>> On jeu., 2023-02-02 at 10:58 +0100, Etienne Carriere wrote:
> >> >>>> Caution: EXT Email
> >> >>>>
> >> >>>> On Thu, 2 Feb 2023 at 09:35, Sumit Garg <sumit.garg@linaro.org>
> >> >>>> wrote:
> >> >>>>> Hi Cyrille,
> >> >>>>>
> >> >>>>> Please don't top post as it makes it harder to follow-up.
> >> >>>>>
> >> >>>>> On Thu, 2 Feb 2023 at 13:26, Cyrille Fleury
> >> >>>>> <cyrille.fleury@nxp.com
> >> >>>>>> wrote:
> >> >>>>>> Hi Sumit, all
> >> >>>>>>
> >> >>>>>> Upstream OP-TEE should support registering a dmabuf since a
> >> >>>>>> while, given how widely dmabuf is used in Linux for passing
> >> >>>>>> buffers around between devices.
> >> >>>>>>
> >> >>>>>> Purpose of the new register_tee_shm ioctl is to allow OPTEE to
> >> >>>>>> use memory allocated from the exiting linux dma buffer. We
> >> >>>>>> don't need to have secure dma-heap up streamed.
> >> >>>>>>
> >> >>>>>> You mentioned secure dma-buffer, but secure dma-buffer is a
> >> >>>>>> dma- buffer, so the work to be done for secure or "regular" dma
> >> >>>>>> buffers by the register_tee_shm ioctl is 100% the same.
> >> >>>>>>
> >> >>>>>> The scope of this ioctl is limited to what existing upstream
> >> >>>>>> dma- buffers are:
> >> >>>>>>         -> sharing buffers for hardware (DMA) access across
> >> >>>>>> multiple device drivers and subsystems, and for synchronizing
> >> >>>>>> asynchronous hardware access.
> >> >>>>>>        -> It means continuous memory only.
> >> >>>>>>
> >> >>>>>> So if we reduce the scope of register tee_shm to exiting dma-
> >> >>>>>> buffer area, the current patch does the job.
> >> >>>>>
> >> >>>>> Do you have a corresponding real world use-case supported by
> >> >>>>> upstream OP-TEE? AFAIK, the Secure Data Path (SDP) use-case is
> >> >>>>> the one supported in OP-TEE upstream but without secure dmabuf
> >> >>>>> heap [1] available, the new ioctl can't be exercised.
> >> >>>>>
> >> >>>>> [1]
> >> >>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> >> >>>>> 2Fg%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a41e
> >> >>>>> dd81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> >> >>>>> 38118829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
> >> >>>>> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sda
> >> >>>>> ta=3DtBh3qNiinzTn%2BgqE8IvGw%2BYvRvo8ztDt4W4O0noEkk8%3D&reserved=
=3D0
> >> >>>>> ithub.com%2FOP-TEE%2Foptee_test%2Fblob%2Fmaster%2Fhost%2Fxtest%2
> >> >>>>> Fsd
> >> >>>>> p_basic.h%23L15&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962
> >> >>>>> fb5
> >> >>>>> 8f6401c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> >> >>>>> C0%
> >> >>>>> 7C638110243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA
> >> >>>>> iLC
> >> >>>>> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sda
> >> >>>>> ta=3D
> >> >>>>> UNB88rvmhQ5qRoIGN%2FpS4cQTES5joM8AjoyAAYzPKl0%3D&reserved=3D0
> >> >>>>
> >> >>>> OP-TEE has some SDP test taht can exercice SDP: 'xtest
> >> >>>> regression_1014'.
> >> >>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2
> >> >>>> Fgi%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a41ed
> >> >>>> d81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> >> >>>> 118829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
> >> >>>> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D%
> >> >>>> 2FDGLzwTOc5%2F30%2BLy4bBVckK0fRJRsvuGcUvp6bfW9Tg%3D&reserved=3D0
> >> >>>> thub.com%2FOP-TEE%2Foptee_test%2Fblob%2F3.20.0%2Fhost%2Fxtest%2Fr
> >> >>>> egr
> >> >>>> ession_1000.c%23L1256&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9
> >> >>>> ff9
> >> >>>> 62fb58f6401c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> >> >>>> C0%
> >> >>>> 7C0%7C638110243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> >> >>>> MDA
> >> >>>> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&s
> >> >>>> dat
> >> >>>> a=3De%2B40rwWvtvVFG8aWZNeu%2FgjMXXvZ3pRhJfHLkdurovs%3D&reserved=3D0
> >> >>>>
> >> >>>> The test relies on old staged ION + local secure dmabuf heaps no
> >> >>>> more maintained, so this test is currently not functional.
> >> >>>> If we upgrade the test to mainline dmabuf alloc means, and apply
> >> >>>> the change discussed here, we should be able to regularly test
> >> >>>> SDP in OP-TEE project CI.
> >> >>>> The part to update is the userland allocation of the dmabuf:
> >> >>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2
> >> >>>> Fgi%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a41ed
> >> >>>> d81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> >> >>>> 118829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
> >> >>>> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D%
> >> >>>> 2FDGLzwTOc5%2F30%2BLy4bBVckK0fRJRsvuGcUvp6bfW9Tg%3D&reserved=3D0
> >> >>>> thub.com%2FOP-TEE%2Foptee_test%2Fblob%2F3.20.0%2Fhost%2Fxtest%2Fs
> >> >>>> dp_
> >> >>>> basic.c%23L91&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962fb5
> >> >>>> 8f6
> >> >>>> 401c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> >> >>>> C63
> >> >>>> 8110243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> >> >>>> Ijo
> >> >>>> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D5rP
> >> >>>> V1j
> >> >>>> qzqjVh2N5pdUW41YwF6EkgIDwfhyfYkgmtdZI%3D&reserved=3D0
> >> >>>>
> >> >>>>
> >> >>>
> >> >>> the test was already updated to support secure dma heap with
> >> >>> Kernel version 5.11 and higher. the userland allocation could be fin=
d here:
> >> >>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> >> >>> git%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a41edd
> >> >>> 81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63811
> >> >>> 8829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> >> >>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DdUNus
> >> >>> R9w0TlzTRiqUUhU8yo%2BUF7QPhsx5t8GQuAA1SU%3D&reserved=3D0
> >> >>> hub.com%2FOP-TEE%2Foptee_test%2Fblob%2F3.20.0%2Fhost%2Fxtest%2Fsdp
> >> >>> _ba
> >> >>> sic.c%23L153&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962fb58f
> >> >>> 640
> >> >>> 1c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> >> >>> 811
> >> >>> 0243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> >> >>> V2l
> >> >>> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D01H96n47
> >> >>> K6R
> >> >>> mBKZQhRdcqX3nE5VBHOXNfGuMmmkVSvc%3D&reserved=3D0
> >> >>>
> >> >>
> >> >> Oh, right. So fine, optee_test is ready for the new flavor of
> >> >> secure buffer fd's.
> >> >>
> >> >>
> >> >>> This upgrade need a Linux dma-buf patch:
> >> >>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> >> >>> lor%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a41edd
> >> >>> 81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63811
> >> >>> 8829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> >> >>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D4iomH
> >> >>> K4kPt6A4OmyioiIFD360bGh39o0d2%2BJGyI3WYM%3D&reserved=3D0
> >> >>> e.kernel.org%2Fall%2F20220805154139.2qkqxwklufjpsfdx%4000037740335
> >> >>> 3%2
> >> >>> FT%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962fb58f6401c59
> >> >>> 780
> >> >>> 8db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638110243
> >> >>> 232
> >> >>> 457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> >> >>> iLC
> >> >>> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DyCS%2BDcuGp%2Ba
> >> >>> fAL
> >> >>> tpw74O1bI0K%2Fwnt%2FOw5ob1ngfDA0E%3D&reserved=3D0
> >> >>
> >> >> @Jens, @Jerome, do we want to pick the 2 necessary Linux patches in
> >> >> our Linux kernel fork (github.com/linaro-swg/linux.git) to exercise
> >> >> SDP in our CI and be ready if dma-buf secure heaps (ref right
> >> >> above) is accepted and merged in mainline kernel?.
> >> >
> >> >How would that help? I mean, when the kernel patches are merged and
> >> >if things break we can make the necessary adjustments in the
> >> >optee_test app or whatever, but in the meantime I don't see much
> >> >point. I suppose the people who are actively developing the patches
> >> >do make sure it works with OP-TEE ;-)
> >> >
> >> >Regards,
> >> >--
> >> >Jerome
> >>
> >> As mentioned in the cover letter, this IOCTL got tested by Jens Wiklande=
r <jens.wiklander@linaro.org>, using Linaro reference board from Hikey 6620:
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> >> s.trustedfirmware.org%2Farchives%2Flist%2Fop-tee%40lists.trustedfirmwa
> >> re.org%2Fthread%2FI3TZN4TBDOUVE567VMMN2TAXGWZNY7S3%2F&data=3D05%7C01%7Cc
> >> yrille.fleury%40nxp.com%7C057d956d144a41edd81808db0db1c7f9%7C686ea1d3b
> >> c2b4c6fa92cd99c5c301635%7C0%7C0%7C638118829451030288%7CUnknown%7CTWFpb
> >> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> >> %3D%7C3000%7C%7C%7C&sdata=3DEHEVIdfHacDVq%2BCdSYg0Tkm1ekQLEI6Vra4elN0%2F
> >> %2F6I%3D&reserved=3D0
> >> It also works on i.MX8M EVK boards.
> >>
> >> My understanding today is we are good to upstream this patch, knowing:
> >>      - Upstream OPTEE driver should support registering a dmabuf since a=
 while, given how widely dmabuf is used in Linux for passing buffers around b=
etween devices.
> >>      - review is OK
> >>      - test environment is already available in optee-test
> >>      - it has been tested on 2 different platforms
> >>      - the scope of the new ioctl is limited to existing feature in
> >> dma-buffer
> >>
> >> What is missing from this list preventing to upstream ?
> >
> >Please address the comments from Etienne and post a new version of the pat=
ch based on the latest kernel. Please try to improve the language in the comm=
it message.
> >
> >Is it possible to update the tests so this can be tested on QEMU in our CI=
 loop? That should help to get the review restarted.
> >
> >Thanks,
> >Jens
> >
>
> Hi Jens
>  Could you point the Etienne comment(s) not addressed by the pull request t=
o add register tee_shm ioctl to linux optee-driver?
>   Last comments from Etienne:
>         -> Oh, right. So fine, optee_test is ready for the new flavor of se=
cure buffer fd's.
>         -> @Jens, @Jerome, do we want to pick the 2 necessary Linux patches=
 in our Linux kernel fork (github.com/linaro-swg/linux.git) to exercise SDP i=
n our CI and be ready if dma-buf secure heaps (ref right above) is accepted a=
nd merged in mainline kernel?.

https://lore.kernel.org/lkml/CAN5uoS-nT1Bi0dhf74Hpv9LS6XPeTCdZ7sujAKNjacZ+PNh=
4xA(a)mail.gmail.com/

There are four comments quite a bit down into the patch.

Cheers,
Jens

--===============7906049357436756153==--

