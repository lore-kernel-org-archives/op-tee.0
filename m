From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] AMDTEE fix for v6.5
Date: Tue, 06 Jun 2023 13:46:46 +0200
Message-ID: <0fac8e65-fe05-4dbf-a634-4620f764e2bd@app.fastmail.com>
In-Reply-To: <20230606075843.GA2792442@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3762888780003458196=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3762888780003458196==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Jun 6, 2023, at 09:58, Jens Wiklander wrote:
> Hello arm-soc maintainers,
>
> Please pull this AMDTEE driver fix to add a return origin field to the
> struct tee_cmd_load_ta used when loading a Trusted Application into the
> AMDTEE. This change is backward compatible.
>
> Note that this isn't a usual Arm driver update. This targets AMD instead,
> but is part of the TEE subsystem.
>
> Thanks,
> Jens
>
> The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:
>
>   Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git 
> tags/amdtee-fix-for-v6.5
>
> for you to fetch changes up to 436eeae0411acdfc54521ddea80ee76d4ae8a7ea:

I see there is only one patch here, and it is marked as 'Cc: stable',
so I assume  you meant this to be include in v6.4, not 6.5. Can you
confirm that?

     Arnd

--===============3762888780003458196==--

