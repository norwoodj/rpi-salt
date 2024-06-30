listen {
  address = "{{ listen_address }}"
  port = {{ listen_port }}
}

namespace "nginx" {
  source = {
    syslog {
      listen_address = "{{ syslog_listen_address }}"
      format = "rfc3164"
      tags = ["nginx"]
    }
  }

  labels {
    app = "stupidchess"
  }

  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $request_length $body_bytes_sent \"$http_referer\" \"$http_user_agent\" rt=\"$request_time\" uct=\"$upstream_connect_time\" uht=\"$upstream_header_time\" urt=\"$upstream_response_time\""

  relabel "path" {
    from = "request"

    match "^([^?]*)[A-Z2-7]{26}([^?]*)(\\?.*)?$" {
      replacement = "$1:uuid$2"
    }

    match "^(.*)\\?.*$" {
      replacement = "$1"
    }

    match "^(.*)$" {
      replacement = "$1"
    }

    split = 2
  }
}
