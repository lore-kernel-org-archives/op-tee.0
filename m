From: Mimi Zohar <zohar@linux.ibm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
Date: Tue, 08 Dec 2020 10:02:57 -0500
Message-ID: <ba6cd934bf7460cf6e9fc101a759a63fdd4e6e9b.camel@linux.ibm.com>
In-Reply-To: <20201204153037.GC4922@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8657032372987491286=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8657032372987491286==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Jarkko,

On Fri, 2020-12-04 at 17:30 +0200, Jarkko Sakkinen wrote:
> On Wed, Dec 02, 2020 at 02:34:07PM -0500, gmail Elaine Palmer wrote:
> > Hi Sumit,  
> > 
> > Thank you for the detailed descriptions and examples of trust sources
> > for Trusted Keys.   A group of us in IBM (Stefan Berger, Ken Goldman,
> > Zhongshu Gu, Nayna Jain, Elaine Palmer, George Wilson, Mimi Zohar)
> > have been doing related work for quite some time, and we have one
> > primary concern and some suggested changes to the document. 
> > 
> > Our primary concern is that describing a TEE as a Trust Source needs
> > to be more specific.   For example, "ARM TrustZone" is not sufficient,
> > but "wolfSSL embedded SSL/TLS library with ARM TrustZone
> > CryptoCell-310" is.  Just because a key is protected by software
> > running in a TEE is not enough to establish trust.  Just like
> > cryptographic modules, a Trust Source should be defined as a specific
> > implementation on specific hardware with well-documented environmental
> > assumptions, dependencies, and threats.
> > 
> > In addition to the above concern, our suggested changes are inline
> > below.
> 
> In order to give a decent review comment it should have two ingredients:
> 
> - Where the existing line of code / text / whatever goes wrong.
> - How it should modified and why that makes sense. And use as plain
>   English and non-academic terms as possible, if it is documentation.
>   Further, scope is only the kernel implementation, no more or no
>   less.
> 
> "do this" is not unfortunately an argument. Feedback is welcome when
> it is supported by something common sensse.

Even after the code is fully debugged, reviewed and tested, our concern
is that people will assume the security guarantees of TEE based trusted
keys to be equivalent to that of a discrete TPM.

> 
> Some meta suggestion of related to email:
> 
> Please also use a proper email client and split your paragraphs into
> at most 80 character lines with new line characters when writing email.
> I prefer to use 72 character line length so that there's some space
> for longer email threads.

Sure, we'll re-post the suggested documentation changes/additions.

Mimi


--===============8657032372987491286==--

