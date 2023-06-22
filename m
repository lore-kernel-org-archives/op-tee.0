From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Date: Thu, 22 Jun 2023 18:04:15 +0300
Message-ID: 
 <CAC_iWjJ28uKVpz_FrJ6dcUjCkrV9w5UO4WRr9SQxYFPmtmj59w@mail.gmail.com>
In-Reply-To: <8ce9f761-347d-1e8c-17d7-241d88c82451@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3519704660718857872=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3519704660718857872==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Jan,

On Thu, 22 Jun 2023 at 17:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 22.06.23 10:51, Masahisa Kojima wrote:
> > This series introduces the tee based EFI Runtime Variable Service.
> >
> > The eMMC device is typically owned by the non-secure world(linux in
> > this case). There is an existing solution utilizing eMMC RPMB partition
> > for EFI Variables, it is implemented by interacting with
> > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > and tee-supplicant. The last piece is the tee-based variable access
> > driver to interact with OP-TEE and StandaloneMM.
> >
> > Changelog:
> > v5 -> v6
> > - new patch #4 is added in this series, #1-#3 patches are unchanged.
> >   automatically update super block flag when the efivarops support
> >   SetVariable runtime service, so that user does not need to manually
> >   remount the efivarfs as RW.
>
> But that is not yet resolving the architectural problem with that
> userspace daemon dependency. What are the next steps for that now?

We are trying to find some cycles to work on that, however, I don't
have a time estimate on that.  But the question is different here.
Since this addresses the problems distros have wrt to SetVariableRT
(even for a limited set of platforms) are we ok pulling this in?  I
can't think of a technical reason we shouldn't.  The supplicant
limitations are known and the firrmwareTPM has a similar set of
problems.

Thanks
/Ilias

>
> Thanks,
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>

--===============3519704660718857872==--

