From: Jérôme Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Why UBSAN is marked as using a lot of memory?
Date: Mon, 05 Feb 2024 15:21:55 +0100
Message-ID: 
 <CA+NB=maN2Zuv1yRXomU9oHr1Ea2qahfwVAqtPn4yNNKzuoPS1Q@mail.gmail.com>
In-Reply-To: <
 <CAEUiM9P9pRto1NSgeEZ0pD55jk6dSp0xd4PaDeKgCnHp+ieV6A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8600946117347884765=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8600946117347884765==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Igor,

On Mon, 5 Feb 2024 at 13:13, Igor Zhbanov <izh1979@gmail.com> wrote:

> Hello,
>
> In the configuration makefile mk/config.mk there are following lines:
>
> # Enable support for detected undefined behavior in C
> # Uses a lot of memory, can't be enabled by default
> CFG_CORE_SANITIZE_UNDEFINED ?= n
>
> I've read the sources of the conditionally compiled ubsan.c and, IIUC,
> how UBSAN is working (mostly by adding simple checks), I don't understand,
> why UBSAN is marked as using a lot of memory.
>
> Is this comment still valid?
>

I don't know, but the latest info about USBSAN is that it fails to build
on the master branch so I can't even try it and check the memory usage :-/

See https://github.com/OP-TEE/optee_os/issues/6463.

-- 
Jerome

>
> Thank you.
>

--===============8600946117347884765==--

