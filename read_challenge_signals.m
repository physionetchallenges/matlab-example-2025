function signals=read_challenge_signals(file,header)

try
    signals=rdsamp(file(1:end-4));
catch
    try

        signals=read_samp(extractBefore(file,'.hea'));
    
    catch

        try
            signals=load(strrep(file,'.hea','.mat'));
            signals=signals.val';
            signals=scale_signals(signals,header);
        catch
            error('%s could not be loaded',file);
        end

    end
end