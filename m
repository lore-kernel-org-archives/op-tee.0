From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 09/14] cma: export cma_alloc() and cma_release()
Date: Mon, 05 May 2025 13:38:38 +0200
Message-ID: 
 <CAHUa44HOq91O0yUWVUKcUzYv9j3xqOU3WsDg9KDXiExcdPO8fQ@mail.gmail.com>
In-Reply-To: <aBTpiMIevmAmp5vr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8047552041624080589=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8047552041624080589==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 2, 2025 at 5:50=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, May 02, 2025 at 11:59:23AM +0200, Jens Wiklander wrote:
> > Export the two functions cma_alloc() and cma_release().
>
> Why?  This is clearly part of a larger series, but you've given those of
> us who are subscribed to linux-mm absolutely no information about why
> you want to do this.

I'm sorry, it's part of this patch: set
https://lore.kernel.org/lkml/20250502100049.1746335-1-jens.wiklander(a)linaro=
.org/
 I'll CC a bit more in the next version of the patch set.

It's needed if the TEE subsystem is built as a load module.

Thanks,
Jens

--===============8047552041624080589==--

