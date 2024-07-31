tableextension 50152 Invest_Currency extends "Currency Exchange Rate"
{
    fields
    {
    }
    procedure GetExchangeRate(Date: Date; Currency: Code[10])ExcRate: Decimal var
        CurrencyExchangeRec: record "Currency Exchange Rate";
    begin
        CurrencyExchangeRec.RESET;
        CurrencyExchangeRec.SETRANGE(CurrencyExchangeRec."Currency Code", Currency);
        CurrencyExchangeRec.SETRANGE("Starting Date", 0D, Date);
        IF CurrencyExchangeRec.FIND('-')THEN ExcRate:=CurrencyExchangeRec."Relational Exch. Rate Amount";
        EXIT(ExcRate);
    end;
}
