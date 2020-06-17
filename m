From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Thu, 18 Jun 2020 02:14:29 +0300
Message-ID: <20200617231429.GD62794@linux.intel.com>
In-Reply-To: <
 <CAFA6WYNEnXm5FOGHGAg4XB-+GXD=C+YMh+6t976=pStU0WshAA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2262320983730692841=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2262320983730692841==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Jun 16, 2020 at 07:02:37PM +0530, Sumit Garg wrote:
> + Luke
> 
> Hi Jarkko,
> 
> Prior to addressing your comments below which seems to show your
> preference for compile time selection of trust source (TPM or TEE), I
> would just like to hear the reasons for this preference especially if
> it makes distro vendor's life difficult [1] to make opinionated
> selection which could rather be achieved dynamically based on platform
> capability.
> 
> [1] https://lkml.org/lkml/2020/6/3/405
> 
> -Sumit

Hmm... I do get the distribution kernel point. OK, lets revert to
dynamic then. Thanks for the remark.

/Jarkko

--===============2262320983730692841==--

