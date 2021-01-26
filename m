From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: simplify i2c access
Date: Tue, 26 Jan 2021 15:09:02 +0100
Message-ID: 
 <CAK8P3a0nZSejOkQScYBPnDP+2H_bo2nmtOqxW1j-F4tb6dbLAA@mail.gmail.com>
In-Reply-To: <20210126114507.GA9282@trex>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5125388972290069601=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5125388972290069601==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2021 at 12:50 PM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
> On 26/01/21, Arnd Bergmann wrote:
> > On Tue, Jan 26, 2021 at 9:08 AM Jorge Ramirez-Ortiz, Foundries
> >
> > The fixes tag only describes which commit introduced the bug, it is irrel=
evant
> > what type of bug this is.
>
> thanks Arnd.
>
> what compiler warnings are defined as kernel bugs? is there a list
> that you use when tracking these?

I consider any warning a bug, a normal kernel build should always be
warning free.

I sometimes send fixes for warnings that only happen with 'make W=3D1',
'make C=3D1' or even 'make W=3D2'. For those, I would only categorize them
as a real bug if they actually cause runtime misbehavior, but there are
some -Wsomething flags that we would like to enable by default in the
future.

      Arnd

--===============5125388972290069601==--

