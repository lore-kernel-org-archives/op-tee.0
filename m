From: David Laight <david.laight.linux@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: Prevent size calculation wraparound on 32-bit kernels
Date: Fri, 02 May 2025 12:41:01 +0000
Message-ID: <20250502134058.0f3e79cc@pumpkin>
In-Reply-To: <
 <CAG48ez1DPWhT2dhd1iptFawWjteh_=pZ4M6Yq5KKCq2DTArnqw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5127824033870539956=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5127824033870539956==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 2 May 2025 14:28:21 +0200
Jann Horn <jannh@google.com> wrote:

> On Thu, May 1, 2025 at 10:02 PM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Mon, 28 Apr 2025 15:06:43 +0200
> > Jann Horn <jannh@google.com> wrote:
> >  
> > > The current code around TEE_IOCTL_PARAM_SIZE() is a bit wrong on
> > > 32-bit kernels: Multiplying a user-provided 32-bit value with the
> > > size of a structure can wrap around on such platforms.
> > >
> > > Fix it by using saturating arithmetic for the size calculation.  
> >
> > Why not just add a sanity check on 'num_params' after it is read.
> > Max is 31 (1024-32)/32), but any sane limit will do because of
> > the buf.buf_len test.  
> 
> That would work, too. I don't know which way looks nicer.

The saturating arithmetic functions are non-obvious and non-trivial.
I looked at the code to check where buf.buf_len came from,
without its sanity check the user could craft a request where it
matched the saturated size.

I think I'd sanity check the number of items and then check that that
buffer length is right for the number of items.

	David

--===============5127824033870539956==--

