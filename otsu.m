I=imread('image.jpg');
figure(1),imshow(I);
figure(2),imhist(I);

h=imhist(I); % Compute histogram
N=sum(h);
max=0;

for i=1:256
    P(i)=h(i)/N;
end

mg = dot([0:255],P(1:256)); % Compute global intensity mean

for T=2:255      % For each threshold
    w0=sum(P(1:T)); % Compute cumulative sum
    u0=dot([0:T-1],P(1:T));%/w0; % Compute cumulative mean
    sigma = ((mg .* w0) - u0)^2; % Compute between-class variance
    sigma = sigma/(w0*(1-w0));
    if sigma>max % compare sigma with max
        max=sigma; % update the value of max
        threshold=T-1; % update threshold
    end
end

bw=im2bw(I,threshold/255); % Convert to Binary image using the desire threshold
figure(3),imshow(bw); % Display the Binary Image