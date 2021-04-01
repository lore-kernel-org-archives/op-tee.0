From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE tracepoints fix for v5.13
Date: Thu, 01 Apr 2021 12:23:31 +0200
Message-ID: <161727243793.583633.7984995735453542553.b4-ty@arndb.de>
In-Reply-To: <20210330082208.GA965793@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3567726192629330674=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3567726192629330674==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

On Tue, 30 Mar 2021 10:22:08 +0200, Jens Wiklander wrote:
> The previous pull request for OP-TEE tracepoints introduced a build
> error when building whithout O=..., apparently many regression builds
> uses that option.
> 
> Please pull this small fix for the build error.
> 
> Thanks,
> Jens
> 
> [...]

You asked for this to be merged for 5.13, but as the change is clearly correct
and required as a build fix, I added it as a fix for 5.12 instead, hope that's
ok.

Merged into arm/fixes, thanks!

merge commit: 3e530f89d72dd1ab31e20d6f8567e357b928705c

       Arnd

--===============3567726192629330674==--

