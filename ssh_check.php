<?php
function check_ssh($host, $port = 22) {
    $connection = @fsockopen($host, $port, $errno, $errstr, 10);
    if (is_resource($connection)) {
        $banner = fgets($connection, 1024);
        fclose($connection);
        if (strpos($banner, 'SSH') !== false) {
            echo "SSH";
            return true;
        }
    }
    echo "Error: Unable to connect to SSH";
    return false;
}
$host = isset($_GET['host']) ? $_GET['host'] : '';
$port = isset($_GET['port']) ? (int)$_GET['port'] : 22;
if (empty($host)) {
    echo "Error: Host parameter is missing";
} else {
    check_ssh($host, $port);
}
?>
