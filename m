From: Kees Cook <keescook@chromium.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Tue, 24 Nov 2020 13:32:44 -0800
Message-ID: <202011241327.BB28F12F6@keescook>
In-Reply-To: <
 <8f5611bb015e044fa1c0a48147293923c2d904e4.camel@HansenPartnership.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1860716234917962715=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1860716234917962715==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Nov 23, 2020 at 08:31:30AM -0800, James Bottomley wrote:
> Really, no ... something which produces no improvement has no value at
> all ... we really shouldn't be wasting maintainer time with it because
> it has a cost to merge.  I'm not sure we understand where the balance
> lies in value vs cost to merge but I am confident in the zero value
> case.

What? We can't measure how many future bugs aren't introduced because the
kernel requires explicit case flow-control statements for all new code.

We already enable -Wimplicit-fallthrough globally, so that's not the
discussion. The issue is that Clang is (correctly) even more strict
than GCC for this, so these are the remaining ones to fix for full Clang
coverage too.

People have spent more time debating this already than it would have
taken to apply the patches. :)

This is about robustness and language wrangling. It's a big code-base,
and this is the price of our managing technical debt for permanent
robustness improvements. (The numbers I ran from Gustavo's earlier
patches were that about 10% of the places adjusted were identified as
legitimate bugs being fixed. This final series may be lower, but there
are still bugs being found from it -- we need to finish this and shut
the door on it for good.)

-- 
Kees Cook

--===============1860716234917962715==--

