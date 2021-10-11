listen {
  port = 4040
}

namespace "nginx" {
  source = {
    files = ["/var/log/stupidchess/nginx-access.log"]
  }

  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\"rt=$request_time uct=\"$upstream_connect_time\" uht=\"$upstream_header_time\" urt=\"$upstream_response_time\""

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
