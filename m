From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: make tee_bus_type const
Date: Tue, 13 Feb 2024 18:28:20 +0100
Message-ID: <2024021315-barstool-viper-6229@gregkh>
In-Reply-To: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5380590573464228552=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5380590573464228552==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Feb 13, 2024 at 11:46:25AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the tee_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--===============5380590573464228552==--

