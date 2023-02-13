From: Ira Weiny <ira.weiny@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
Date: Mon, 13 Feb 2023 10:53:50 -0800
Message-ID: <63ea873eafd82_14e70a2944c@iweiny-mobl.notmuch>
In-Reply-To: <
 <CAHUa44GAM=meibiSDjjWb0wKmHzud6JddE3W=zG3XCFfgP+Sag@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4068998788874758699=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4068998788874758699==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Jens Wiklander wrote:
> Hi Ira,
>=20
> On Fri, Feb 10, 2023 at 9:28 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > Ira Weiny wrote:
> > > Sumit Garg wrote:
> > > > On Sat, 4 Feb 2023 at 09:36, Ira Weiny <ira.weiny@intel.com> wrote:
> > > > >
> > > > > Sumit,
> > > > >
> > > > > I did not see a follow up on this series per your last email.[1]  I=
'd like to
> > > > > move forward with getting rid of kmap_to_page().  So Hopefully this=
 can land
> > > > > and you can build on this rather than the other way around?
> > > >
> > > > Apologies Ira for keeping you waiting. Actually I was fully involved
> > > > with other high priority work with my upstream review backlog
> > > > increasing. So I wasn't able to devote time to this work. Sure I will
> > > > rebase my work on top of your changes.
> > >
> > > No problem on my end.  I just wanted to ensure that I did not miss
> > > something.
> >
> > Andrew, can I get an ack on patches 1 and 4 for this series?  I realized
> > that perhaps I was not clear on my expectations of this series.  I was
> > thinking this would be easiest to go through the tee subsystem tree.
> >
> > Sumit or Jens, is that ok with you all?
>=20
> Sure, I'll take it. The timing is a bit unfortunate, it's likely too
> close to the merge window to be included there. However, I'll pick it
> up and add it to linux-next so it's ready for the 6.4 merge window.

6.4 is fine with me.

Thanks everyone!
Ira

--===============4068998788874758699==--

