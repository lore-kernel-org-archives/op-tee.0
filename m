From: Eugene Syromiatnikov <esyr@redhat.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and
 TEE_IOCTL_SHM_DMA_BUF
Date: Wed, 08 Jun 2022 15:52:54 +0200
Message-ID: <20220608135116.GA27854@asgard.redhat.com>
In-Reply-To: <20220425141617.23925-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8266466391228865664=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8266466391228865664==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 09:16:17AM -0500, Andrew Davis wrote:
> These look to be leftover from an early edition of this driver. Userspace
> does not need this information. Checking all users of this that I have
> access to I have verified no one is using them.

This change has broken build of strace's test suite against the latest kernel
headers[1];  the usage prety much shows up in the Debian's code search[2].

[1] https://github.com/strace/strace/runs/6794205205?check_suite_focus=3Dtrue=
#step:4:3862
[2] https://codesearch.debian.net/search?q=3DTEE_IOCTL_SHM_MAPPED+package%3A%=
5CQstrace%5CE&literal=3D1

> They leak internal use flags out to userspace. Even more they are not
> correct anymore after a45ea4efa358. Lets drop these flags before
> someone does try to use them for something and they become ABI.


--===============8266466391228865664==--

