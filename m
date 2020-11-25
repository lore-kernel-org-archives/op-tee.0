From: Edward Cree <ecree.xilinx@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 23:02:40 +0000
Message-ID: <99a9ffd7-6356-b81d-6e08-7ed74b6fb82c@gmail.com>
In-Reply-To: <202011241324.B3439A2@keescook>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4325780742108708032=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4325780742108708032==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On 24/11/2020 21:25, Kees Cook wrote:
> I still think this isn't right -- it's a case statement that runs off
> the end without an explicit flow control determination.

Proves too much — for instance
    case foo:
    case bar:
        thing;
        break;
 doesn't require a fallthrough; after case foo:, and afaik
 no-one is suggesting it should.  Yet it, too, is "a case
 statement that runs off the end without an explicit flow
 control determination".

-ed

--===============4325780742108708032==--

