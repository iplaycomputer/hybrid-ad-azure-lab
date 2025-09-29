# Exercise 0: Networking – Simulated Site-to-Site VPN (VNet-to-VNet)

Objective: Simulate hybrid connectivity between an on‑premises network and Azure using two VNets connected by a VNet‑to‑VNet VPN. This provides the foundation for hybrid identity and management labs that follow.

Estimated time: 35–50 minutes

Prereqs

- Azure subscription with permission to create VNets/VPN gateways/public IPs
- Resource group created (or use an existing one)
- Region: use the same region for both VNets for simplicity

What you will build

- OnPrem VNet (10.10.0.0/16) with subnet 10.10.1.0/24 and GatewaySubnet 10.10.255.0/27
- Azure VNet (10.20.0.0/16) with subnet 10.20.1.0/24 and GatewaySubnet 10.20.255.0/27
- Two VPN gateways (route‑based) with public IPs
- Two local network gateways to represent the opposite site
- Two connections (one per direction)

Safety notes

- This lab uses Azure VNet‑to‑VNet; in production you would use S2S from an on‑prem device. Costs apply while gateways are running; delete after use to avoid charges.

## Steps

1. Variables

   - Resource group: `{{AzureResourceGroupName}}`
   - Region: `{{AzureRegion}}` (e.g., eastus)

2. Create VNets and subnets
   - OnPrem VNet: 10.10.0.0/16
     - Subnet: 10.10.1.0/24
     - GatewaySubnet: 10.10.255.0/27 (name must be GatewaySubnet)
   - Azure VNet: 10.20.0.0/16
     - Subnet: 10.20.1.0/24
     - GatewaySubnet: 10.20.255.0/27

3. Create public IPs (2)
   - PIP-OnPremGW, PIP-AzureGW (SKU: Standard)

4. Create VPN gateways (2)
   - GW type: VPN; VPN type: Route‑based; SKU: VpnGw1
   - Associate each with its VNet’s GatewaySubnet and respective PIP

5. Create local network gateways (2)
    - LNG-OnPrem represents Azure side:
       - Address space: 10.20.0.0/16
       - Gateway IP address: `{{AzureGatewayPublicIp}}`
    - LNG-Azure represents OnPrem side:
       - Address space: 10.10.0.0/16
       - Gateway IP address: `{{OnPremGatewayPublicIp}}`

6. Create shared key
   - Use a simple preshared key for the lab, e.g., `P@ssw0rd123!` (store securely in a key vault for production)

7. Create connections (2)
   - OnPremGW → LNG-OnPrem (shared key)
   - AzureGW → LNG-Azure (shared key)

8. Validate
   - Wait for connections to show Status: Succeeded
   - Deploy a tiny VM in each subnet and test ICMP between 10.10.1.0/24 and 10.20.1.0/24 (allow ping in NSG and Windows Firewall)

## Clean up (to avoid charges)

- Delete both VPN gateways and public IPs, then VNets

## Tips

- If connection stays in Connecting: verify address spaces don’t overlap and the shared key matches on both connections
- NSG rules often block ping/RDP; allow as needed for testing only
- You can script this with Bicep/Terraform later; the exercise uses portal for clarity
