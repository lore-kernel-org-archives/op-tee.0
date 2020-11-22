From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Sun, 22 Nov 2020 11:53:55 -0800
Message-ID: 
 <dbd2cb703ed9eefa7dde9281ea26ab0f7acc8afe.camel@HansenPartnership.com>
In-Reply-To: <d8d1e9add08cdd4158405e77762d4946037208f8.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7765047644443897848=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7765047644443897848==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-11-22 at 11:22 -0800, Joe Perches wrote:
> On Sun, 2020-11-22 at 11:12 -0800, James Bottomley wrote:
> > On Sun, 2020-11-22 at 10:25 -0800, Joe Perches wrote:
> > > On Sun, 2020-11-22 at 10:21 -0800, James Bottomley wrote:
> > > > Please tell me our reward for all this effort isn't a single
> > > > missing error print.
> > > 
> > > There were quite literally dozens of logical defects found
> > > by the fallthrough additions.  Very few were logging only.
> > 
> > So can you give us the best examples (or indeed all of them if
> > someone is keeping score)?  hopefully this isn't a US election
> > situation ...
> 
> Gustavo?  Are you running for congress now?
> 
> https://lwn.net/Articles/794944/

That's 21 reported fixes of which about 50% seem to produce no change
in code behaviour at all, a quarter seem to have no user visible effect
with the remaining quarter producing unexpected errors on obscure
configuration parameters, which is why no-one really noticed them
before.

James



--===============7765047644443897848==--

