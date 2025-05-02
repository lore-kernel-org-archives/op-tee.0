From: Jann Horn <jannh@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: Prevent size calculation wraparound on 32-bit kernels
Date: Fri, 02 May 2025 14:28:21 +0200
Message-ID: 
 <CAG48ez1DPWhT2dhd1iptFawWjteh_=pZ4M6Yq5KKCq2DTArnqw@mail.gmail.com>
In-Reply-To: <20250501210158.5b2c86a7@pumpkin>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4891763262978630770=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4891763262978630770==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, May 1, 2025 at 10:02 PM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 28 Apr 2025 15:06:43 +0200
> Jann Horn <jannh@google.com> wrote:
>
> > The current code around TEE_IOCTL_PARAM_SIZE() is a bit wrong on
> > 32-bit kernels: Multiplying a user-provided 32-bit value with the
> > size of a structure can wrap around on such platforms.
> >
> > Fix it by using saturating arithmetic for the size calculation.
>
> Why not just add a sanity check on 'num_params' after it is read.
> Max is 31 (1024-32)/32), but any sane limit will do because of
> the buf.buf_len test.

That would work, too. I don't know which way looks nicer.

--===============4891763262978630770==--

