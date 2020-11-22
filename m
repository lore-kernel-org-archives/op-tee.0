From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Sun, 22 Nov 2020 15:04:36 -0800
Message-ID: 
 <c3371b7c15ed30b92e9bb8609ff65bdaa0ef61fa.camel@HansenPartnership.com>
In-Reply-To: <alpine.LNX.2.23.453.2011230938390.7@nippy.intranet>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3687713167620987189=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3687713167620987189==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-11-23 at 09:54 +1100, Finn Thain wrote:
> But is anyone keeping score of the regressions? If unreported bugs
> count, what about unreported regressions?

Well, I was curious about the former (obviously no tool will tell me
about the latter), so I asked git what patches had a fall-through
series named in a fixes tag and these three popped out:

9cf51446e686 bpf, powerpc: Fix misuse of fallthrough in bpf_jit_comp()
6a9dc5fd6170 lib: Revert use of fallthrough pseudo-keyword in lib/
91dbd73a1739 mips/oprofile: Fix fallthrough placement

I don't think any of these is fixing a significant problem, but they
did cause someone time and trouble to investigate.

James



--===============3687713167620987189==--

