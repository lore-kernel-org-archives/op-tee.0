From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] Make tee_bus_type const for v6.9
Date: Mon, 04 Mar 2024 17:26:23 +0100
Message-ID: <560b697d-4343-4e69-986d-6c3f4daa637c@app.fastmail.com>
In-Reply-To: <20240216142700.GA3863398@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0978242233275428719=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0978242233275428719==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, Feb 16, 2024, at 15:27, Jens Wiklander wrote:
> Hello arm-soc maitainers,
>
> Please pull this small patch making tee_bus_type const.
>
> Thanks,
> Jens
>
> The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:
>
>   Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git/ 
> tags/tee-bus-type-for-v6.9
>
> for you to fetch changes up to 1d044941d53855ca06e4fa34936ff7273c8641dd:
>
>   tee: make tee_bus_type const (2024-02-15 08:28:24 +0100)
>
> ----------------------------------------------------------------
> tee: make tee_bus_type const
>

My soc/drivers branch was based on -rc1, not -rc2, and
I did not want to do a backmerge of the rc2 contents into
it, so I ended up just cherry-picking this trivial change.

I hope that's ok.

     Arnd

--===============0978242233275428719==--

