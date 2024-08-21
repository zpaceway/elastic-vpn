<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OpenVPN Server Setup</title>
</head>
<body>

<h1>OpenVPN Server Setup</h1>

<p>This is a local implementation of an OpenVPN server running on Ubuntu using the Docker image <code>kylemanna/openvpn</code>.</p>

<h2>Prerequisites</h2>
<ul>
    <li><strong>Vagrant:</strong> The server is set up as a 1GB machine using Vagrant.</li>
    <li><strong>VirtualBox:</strong> You must have VirtualBox installed to manage the virtual machine.</li>
</ul>

<h2>Getting Started</h2>
<p>There are several built-in commands available to help you work with the OpenVPN server. These commands are located in the <code>.local</code> folder:</p>

<h3>Command List</h3>
<ul>
    <li>
        <strong><code>.local\client.cmd</code>:</strong> Generates a new client on the OpenVPN server.
    </li>
    <li>
        <strong><code>.local\credentials.cmd</code>:</strong> Retrieves the credentials of a user on the server and places them under the <code>clients</code> folder.
    </li>
    <li>
        <strong><code>.local\destroy.cmd</code>:</strong> Destroys the VPN server.
    </li>
    <li>
        <strong><code>.local\ip.cmd</code>:</strong> Retrieves the IP addresses of the server.
    </li>
    <li>
        <strong><code>.local\ssh.cmd</code>:</strong> Connects to the server via SSH.
    </li>
    <li>
        <strong><code>.local\start.cmd</code>:</strong> Creates the VPN from scratch. If another VPN is already running, you must destroy it first.
    </li>
</ul>

<h2>First-Time Usage</h2>
<ol>
    <li>Run <code>.local\start.cmd</code> to spin up a new VPN server.</li>
    <li>Create a new client with <code>.local\client.cmd &lt;username&gt;</code>.</li>
    <li>Get the credentials of the client with <code>.local\credentials.cmd &lt;username&gt;</code>.</li>
    <li>Locate the credentials file. Replace the <code>localhost</code> entry in the credentials file with the IP address of the server, which you can obtain using <code>.local\ip.cmd</code>.</li>
    <li>Import the credentials file into your OpenVPN client.</li>
</ol>

<h2>Usage</h2>
<p>Follow the steps below to manage your OpenVPN server:</p>
<ol>
    <li>Ensure you have Vagrant and VirtualBox installed.</li>
    <li>Use the commands in the <code>.local</code> folder to manage the OpenVPN server as needed.</li>
</ol>

</body>
</html>
