From: Jakub Kicinski <kuba@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Fri, 20 Nov 2020 10:53:44 -0800
Message-ID: 
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4138882953764328147=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4138882953764328147==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote:
> This series aims to fix almost all remaining fall-through warnings in
> order to enable -Wimplicit-fallthrough for Clang.
> 
> In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> add multiple break/goto/return/fallthrough statements instead of just
> letting the code fall through to the next case.
> 
> Notice that in order to enable -Wimplicit-fallthrough for Clang, this
> change[1] is meant to be reverted at some point. So, this patch helps
> to move in that direction.
> 
> Something important to mention is that there is currently a discrepancy
> between GCC and Clang when dealing with switch fall-through to empty case
> statements or to cases that only contain a break/continue/return
> statement[2][3][4].

Are we sure we want to make this change? Was it discussed before?

Are there any bugs Clangs puritanical definition of fallthrough helped
find?

IMVHO compiler warnings are supposed to warn about issues that could
be bugs. Falling through to default: break; can hardly be a bug?!

--===============4138882953764328147==--

