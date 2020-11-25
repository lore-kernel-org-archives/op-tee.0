From: Finn Thain <fthain@telegraphics.com.au>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Thu, 26 Nov 2020 08:33:24 +1100
Message-ID: <alpine.LNX.2.23.453.2011260750300.6@nippy.intranet>
In-Reply-To: <
 <CAKwvOdkGBn7nuWTAqrORMeN1G+w3YwBfCqqaRD2nwvoAXKi=Aw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2741099789656214221=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2741099789656214221==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2020, Nick Desaulniers wrote:

> So developers and distributions using Clang can't have 
> -Wimplicit-fallthrough enabled because GCC is less strict (which has 
> been shown in this thread to lead to bugs)?  We'd like to have nice 
> things too, you know.
> 

Apparently the GCC developers don't want you to have "nice things" either. 
Do you think that the kernel should drop gcc in favour of clang?
Or do you think that a codebase can somehow satisfy multiple checkers and 
their divergent interpretations of the language spec?

> This is not a shiny new warning; it's already on for GCC and has existed 
> in both compilers for multiple releases.
> 

Perhaps you're referring to the compiler feature that lead to the 
ill-fated, tree-wide /* fallthrough */ patch series.

When the ink dries on the C23 language spec and the implementations figure 
out how to interpret it then sure, enforce the warning for new code -- the 
cost/benefit analysis is straight forward. However, the case for patching 
existing mature code is another story.

--===============2741099789656214221==--

