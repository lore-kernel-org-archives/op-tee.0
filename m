From: Judy Wang <wangjudy@microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [EXTERNAL] Re: Current design of tee-supplicant can't support
 ftpm requests during kernel space bootup
Date: Wed, 27 Jul 2022 02:17:24 +0000
Message-ID: <PUZP153MB069734A82D2FDF9B7F5BFD4FDC979@PUZP153MB0697.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <
 <CAFA6WYPuTAQmYOPdZ+eG2TJD3JFfeV3TMkPD8ZLeAXW=Vp-5OA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4402721568078059141=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4402721568078059141==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

If a fast path to the MMC driver isn't an option due to concerns of affecting=
 RPMB emulation codes. Any other suggestions we could solve this issue?
Thank you.

Judy.

-----Original Message-----
From: Sumit Garg <sumit.garg@linaro.org>=20
Sent: Tuesday, July 26, 2022 12:37 PM
To: J=C3=A9r=C3=B4me Forissier <jerome@forissier.org>
Cc: Judy Wang <wangjudy@microsoft.com>; op-tee(a)lists.trustedfirmware.org;=
 Carl Lamb <Carl.Lamb@microsoft.com>; Tyler Hicks <Tyler.Hicks@microsoft.=
com>
Subject: Re: [EXTERNAL] Re: Current design of tee-supplicant can't support ft=
pm requests during kernel space bootup

[You don't often get email from sumit.garg(a)linaro.org. Learn why this is im=
portant at https://aka.ms/LearnAboutSenderIdentification ]

On Mon, 25 Jul 2022 at 19:44, J=C3=A9r=C3=B4me Forissier <jerome@forissier.=
org> wrote:
>
>
> On Thu, Jul 21, 2022 at 11:46 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Thu, 21 Jul 2022 at 14:41, Judy Wang <wangjudy@microsoft.com> wrote:
>>
>> > I can see the whole design is rooted with the idea of having tee-supplic=
ant as the servant, don't think it's worth to flip the whole design just to f=
ill the gap before user space is up. We haven't really come up with a design =
so will keep you posted.
>>
>> You don't need to flip the tee-supplicant design but rather just=20
>> handle RPMB requests in the kernel itself if it's supported by MMC=20
>> driver (you need a similar hook in the kernel as we have in u-boot=20
>> [1]). All other OP-TEE RPC requests unhandled by the kernel can be=20
>> forwarded to the user-mode tee-supplicant.
>
>
> Correct but please keep in mind that we have RPMB emulation code inside tee=
-supplicant, which is quite useful for testing. Therefore any "fast path" to =
the MMC driver inside the OP-TEE driver should probably be opt-out.
>

Agree.

-Sumit

> --
> Jerome

--===============4402721568078059141==--

