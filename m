From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Fri, 20 Nov 2020 13:04:55 -0600
Message-ID: <4609d49b-4dd3-c017-b76e-a8a536871c05@embeddedor.com>
In-Reply-To: <
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0586101424417462869=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0586101424417462869==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

On 11/20/20 12:53, Jakub Kicinski wrote:
> On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote:
>> This series aims to fix almost all remaining fall-through warnings in
>> order to enable -Wimplicit-fallthrough for Clang.
>>
>> In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
>> add multiple break/goto/return/fallthrough statements instead of just
>> letting the code fall through to the next case.
>>
>> Notice that in order to enable -Wimplicit-fallthrough for Clang, this
>> change[1] is meant to be reverted at some point. So, this patch helps
>> to move in that direction.
>>
>> Something important to mention is that there is currently a discrepancy
>> between GCC and Clang when dealing with switch fall-through to empty case
>> statements or to cases that only contain a break/continue/return
>> statement[2][3][4].
>=20
> Are we sure we want to make this change? Was it discussed before?
>=20
> Are there any bugs Clangs puritanical definition of fallthrough helped
> find?
>=20
> IMVHO compiler warnings are supposed to warn about issues that could
> be bugs. Falling through to default: break; can hardly be a bug?!

The justification for this is explained in this same changelog text:

Now that the -Wimplicit-fallthrough option has been globally enabled[5],
any compiler should really warn on missing either a fallthrough annotation
or any of the other case-terminating statements (break/continue/return/
goto) when falling through to the next case statement. Making exceptions
to this introduces variation in case handling which may continue to lead
to bugs, misunderstandings, and a general lack of robustness. The point
of enabling options like -Wimplicit-fallthrough is to prevent human error
and aid developers in spotting bugs before their code is even built/
submitted/committed, therefore eliminating classes of bugs. So, in order
to really accomplish this, we should, and can, move in the direction of
addressing any error-prone scenarios and get rid of the unintentional
fallthrough bug-class in the kernel, entirely, even if there is some minor
redundancy. Better to have explicit case-ending statements than continue to
have exceptions where one must guess as to the right result. The compiler
will eliminate any actual redundancy.

Note that there is already a patch in mainline that addresses almost
40,000 of these issues[6].

[1] commit e2079e93f562c ("kbuild: Do not enable -Wimplicit-fallthrough for c=
lang for now")
[2] ClangBuiltLinux#636
[3] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D91432
[4] https://godbolt.org/z/xgkvIh
[5] commit a035d552a93b ("Makefile: Globally enable fall-through warning")
[6] commit 4169e889e588 ("include: jhash/signal: Fix fall-through warnings fo=
r Clang")

Thanks
--
Gustavo

--===============0586101424417462869==--

