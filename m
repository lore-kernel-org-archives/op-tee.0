From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
Date: Fri, 29 Jan 2021 14:58:20 +0100
Message-ID: 
 <CAK8P3a0Nm=aeXSsLVuaEo9D-Kda-xXSWMsgjgNSo2H8Qfh5qfA@mail.gmail.com>
In-Reply-To: <20210125095445.1524477-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1626128715846529073=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1626128715846529073==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Jan 25, 2021 at 10:54 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Testing need_resched() before cond_resched() is not needed as an
> equivalent test is done internally in cond_resched(). So drop the
> need_resched() test.
>
> Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

--===============1626128715846529073==--

