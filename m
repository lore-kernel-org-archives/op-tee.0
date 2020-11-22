From: Joe Perches <joe@perches.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Sun, 22 Nov 2020 10:25:37 -0800
Message-ID: <ca071decb87cc7e905411423c05a48f9fd2f58d7.camel@perches.com>
In-Reply-To: <
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4623712351269076771=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4623712351269076771==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-11-22 at 10:21 -0800, James Bottomley wrote:
> Please tell me
> our reward for all this effort isn't a single missing error print.

There were quite literally dozens of logical defects found
by the fallthrough additions.  Very few were logging only.




--===============4623712351269076771==--

