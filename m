From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE driver for v5.11
Date: Thu, 26 Nov 2020 22:00:20 +0100
Message-ID: 
 <CAK8P3a2CDp0KwCZjffA78fXUqOfAkvUb8Q=R64830fvvn_WG2w@mail.gmail.com>
In-Reply-To: <20201125120134.GA1642471@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2994475995690630028=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2994475995690630028==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Nov 25, 2020 at 1:01 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull this small patch which allows the OP-TEE driver to work with
> ARMv7 based single CPU systems.

Can you rebase that branch onto -rc1? I had started the arm/drivers
branch early on top of that, so I'd prefer to avoid a backmerged.

For the commit itself, shouldn't that be marked as a bugfix and get
merged into v5.10 instead? If it should, you don't have to rebase
since the arm/fixes branch is already ahead.

Also, it would be nice to Cc linux-arm-kernel on the pull request
in addition to linux-kernel.

       Arnd

--===============2994475995690630028==--

