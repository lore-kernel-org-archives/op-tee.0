From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Build breakage in next-20210330 due to optee_trace.h
Date: Wed, 31 Mar 2021 08:27:11 +0200
Message-ID: 
 <CAHUa44Hk24NGw_b46-F2xpHNj9Rj5hw-=ERKGg99N-1SjjeUOA@mail.gmail.com>
In-Reply-To: <20210331020207.l56wft5mjucieg2k@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3227479337465776348=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3227479337465776348==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Pratyush,

On Wed, Mar 31, 2021 at 4:03 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi,
>
> I recently rebased a dev branch on top of next-20210330 (4143e05b7b17)
> and I notice a build error from the optee driver:
>
>   In file included from drivers/tee/optee/call.c:18:
>   In file included from drivers/tee/optee/optee_trace.h:67:
>   ./include/trace/define_trace.h:95:10: fatal error: './optee_trace.h' file=
 not found
>   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/trace/define_trace.h:90:32: note: expanded from macro 'TRACE_IN=
CLUDE'
>   # define TRACE_INCLUDE(system) __TRACE_INCLUDE(system)
>                                  ^~~~~~~~~~~~~~~~~~~~~~~
>   ./include/trace/define_trace.h:87:34: note: expanded from macro '__TRACE_=
INCLUDE'
>   # define __TRACE_INCLUDE(system) __stringify(TRACE_INCLUDE_PATH/system.h)
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/linux/stringify.h:10:27: note: expanded from macro '__stringify'
>   #define __stringify(x...)       __stringify_1(x)
>                                   ^~~~~~~~~~~~~~~~
>   ./include/linux/stringify.h:9:29: note: expanded from macro '__stringify_=
1'
>   #define __stringify_1(x...)     #x
>                                   ^~
>   <scratch space>:135:1: note: expanded from here
>   "./optee_trace.h"
>   ^~~~~~~~~~~~~~~~~
>   1 error generated.
>
> The config is attached. I am building using clang.
>
>   $ clang --version
>   clang version 11.1.0
>   Target: x86_64-pc-linux-gnu
>   Thread model: posix
>   InstalledDir: /usr/bin

Thanks for reporting, this should hopefully be taken care of by
https://lkml.org/lkml/2021/3/25/2

Cheers,
Jens

--===============3227479337465776348==--

