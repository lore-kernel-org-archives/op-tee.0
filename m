From: Joe Perches <joe@perches.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Mon, 23 Nov 2020 17:05:30 -0800
Message-ID: <e72a1aaef8673553a3ee9dfa033d6e893e00abcd.camel@perches.com>
In-Reply-To: <alpine.LNX.2.23.453.2011241036520.7@nippy.intranet>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0122517865352623014=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0122517865352623014==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-11-24 at 11:58 +1100, Finn Thain wrote:
> it's not for me to prove that such patches don't affect code 
> generation. That's for the patch author and (unfortunately) for reviewers.

Ideally, that proof would be provided by the compilation system itself
and not patch authors nor reviewers nor maintainers.

Unfortunately gcc does not guarantee repeatability or deterministic output.
To my knowledge, neither does clang.



--===============0122517865352623014==--

