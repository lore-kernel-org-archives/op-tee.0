From: Igor Zhbanov <izh1979@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Why UBSAN is marked as using a lot of memory?
Date: Fri, 09 Feb 2024 15:49:29 +0300
Message-ID: 
 <CAEUiM9N4z+btycMir_Mgr1JgqxmhLhkeuh=FheB+ENyjmydeoA@mail.gmail.com>
In-Reply-To: <
 <CAHUa44Fjrc5yVm+zrfkXkN-5Ja85iTmm6WCDcgRELc=L8S8mCQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1463965939367501384=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1463965939367501384==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Jens,

Fri, 9 Feb. 2024 г. в 14:33, Jens Wiklander <jens.wiklander@linaro.org>:

> Hi Igor,
>
> On Mon, Feb 5, 2024 at 5:45 PM Igor Zhbanov <izh1979@gmail.com> wrote:
>
> > So, I suppose that the overhead for OP-TEE should also be small, as there
> > is no detailed
> > error logging. But, of course, it is better to be tested.
>
> I guess that depends on what you mean by detailed, it prints file
> name, line, and column when logging.
>

I hoped, it is possible to run UBSAN in minimalistic mode, where it would
just print the current IP
of violation instruction (and optionally reset the device). Then the
overhead should be acceptable.

Thanks.

--===============1463965939367501384==--

