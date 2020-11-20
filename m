From: Joe Perches <joe@perches.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Fri, 20 Nov 2020 10:28:48 -0800
Message-ID: <3e0bbb1644fe53d79322c2feb28ccaf3e20c0e94.camel@perches.com>
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5453078861078980013=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5453078861078980013==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-11-20 at 12:21 -0600, Gustavo A. R. Silva wrote:
> Hi all,
> 
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

This was a bit hard to parse for a second or three.

Thanks Gustavo.

How was this change done?



--===============5453078861078980013==--

