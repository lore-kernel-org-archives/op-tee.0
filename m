From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
Date: Mon, 13 Feb 2023 16:02:34 +0100
Message-ID: 
 <CAHUa44GAM=meibiSDjjWb0wKmHzud6JddE3W=zG3XCFfgP+Sag@mail.gmail.com>
In-Reply-To: <63e6a8b798a_145760294a6@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0040800330628825078=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0040800330628825078==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Ira,

On Fri, Feb 10, 2023 at 9:28 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> Ira Weiny wrote:
> > Sumit Garg wrote:
> > > On Sat, 4 Feb 2023 at 09:36, Ira Weiny <ira.weiny@intel.com> wrote:
> > > >
> > > > Sumit,
> > > >
> > > > I did not see a follow up on this series per your last email.[1]  I'd=
 like to
> > > > move forward with getting rid of kmap_to_page().  So Hopefully this c=
an land
> > > > and you can build on this rather than the other way around?
> > >
> > > Apologies Ira for keeping you waiting. Actually I was fully involved
> > > with other high priority work with my upstream review backlog
> > > increasing. So I wasn't able to devote time to this work. Sure I will
> > > rebase my work on top of your changes.
> >
> > No problem on my end.  I just wanted to ensure that I did not miss
> > something.
>
> Andrew, can I get an ack on patches 1 and 4 for this series?  I realized
> that perhaps I was not clear on my expectations of this series.  I was
> thinking this would be easiest to go through the tee subsystem tree.
>
> Sumit or Jens, is that ok with you all?

Sure, I'll take it. The timing is a bit unfortunate, it's likely too
close to the merge window to be included there. However, I'll pick it
up and add it to linux-next so it's ready for the 6.4 merge window.

Thanks,
Jens

--===============0040800330628825078==--

