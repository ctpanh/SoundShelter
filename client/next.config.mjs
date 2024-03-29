/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "photo-zmp3.zmdcdn.me",
        port: "",
      },
    ],
  },
};

export default nextConfig;
