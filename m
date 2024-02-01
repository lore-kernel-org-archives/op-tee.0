From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Thu, 01 Feb 2024 12:26:53 +0100
Message-ID: 
 <CAHUa44HFiShTKrY33iUsi0fq++4YrFva503wh1pJT4GZ7z7ocA@mail.gmail.com>
In-Reply-To: <2024013108-hamster-audacious-9e3a@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2026315870733308591=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2026315870733308591==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, Jan 31, 2024 at 10:13 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 31, 2024 at 06:43:45PM +0100, Jens Wiklander wrote:
> > +struct class rpmb_class = {
>
> This structure should be marked as 'const', right?

You're right, of course.

>
> > +     .name = "rpmb",
> > +     .dev_release = rpmb_dev_release,
> > +};
> > +EXPORT_SYMBOL(rpmb_class);
>
> EXPORT_SYMBOL_GPL() to match all the other exports in this file please.

Sure, I'll fix it.

Thanks,
Jens

>
> thanks,
>
> greg k-h

--===============2026315870733308591==--

