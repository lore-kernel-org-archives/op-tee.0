From: Eli Friedman <efriedma@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [llvm-dev] Aarch64: unaligned access despite -mstrict-align
Date: Mon, 01 Jun 2020 17:34:49 +0000
Message-ID: <BY5PR02MB70922EBEB0A9D640A3CE68FCCA8A0@BY5PR02MB7092.namprd02.prod.outlook.com>
In-Reply-To: <4c149e1a-7326-152c-de39-7008a9be9751@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5198814079551077414=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5198814079551077414==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

See https://reviews.llvm.org/D76113 and my followup https://reviews.llvm.org/=
D77599 .  (I didn't really think about it at the time, but maybe worth nomina=
ting for 10.0.1.)

-Eli

-----Original Message-----
From: llvm-dev <llvm-dev-bounces@lists.llvm.org> On Behalf Of Jerome Foriss=
ier via llvm-dev
Sent: Monday, June 1, 2020 9:52 AM
To: Sjoerd Meijer <Sjoerd.Meijer@arm.com>; llvm-dev(a)lists.llvm.org
Cc: op-tee(a)lists.trustedfirmware.org
Subject: [EXT] Re: [llvm-dev] Aarch64: unaligned access despite -mstrict-align

On 6/1/20 6:26 PM, Sjoerd Meijer wrote:
> Sorry, quick message to ignore what I wrote before, I got myself confused (=
probably you too),

:)

> With a recent trunk build I get this:
>
> f:
>         adrp    x8, g
>         ldr     x8, [x8, :lo12:g]
>         mov     w2, #16
>         mov     x1, x0
>         mov     x0, x8
>         b       memcmp
>
> This looks more correct, and I need to look a bit more into this (and how c=
lang 10.0.0 behaves).

Indeed I would be quite happy with that ;-) Good to know that master
generated this. If you would you like me to bisect and identify the
commit that changed the behavior, please let me know.

Thanks,
--
Jerome
_______________________________________________
LLVM Developers mailing list
llvm-dev(a)lists.llvm.org
https://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev

--===============5198814079551077414==--

