report 50454 "Asset Register"
{
    ApplicationArea = All;
    Caption = 'Asset Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Asset Register.rdl';

    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "No.", "Fixed Asset Type", "FA Subclass Code", "FA Subcategory";

            column(No_FixedAsset; "No.")
            {
            }
            column(Description_FixedAsset; Description)
            {
            }
            column(SerialNo_FixedAsset; "Serial No.")
            {
            }
            column(LocationCode_FixedAsset; "Location Code")
            {
            }
            column(FALocationCode_FixedAsset; "FA Location Code")
            {
            }
            column(Dateofpurchase_FixedAsset; "Date of purchase")
            {
            }
            column(NetBookValue_FixedAsset; NetBookValue)
            {
            }
            column(ResponsibleEmployee_FixedAsset; "Responsible Employee")
            {
            }
            column(Comment_FixedAsset; Comment)
            {
            }
            column(DateofCommencement_FixedAsset; "Date of Commencement")
            {
            }
            column(Asset_Condition; "Asset Condition")
            {
            }
            column(Tag_Number; "Tag Number")
            {
            }
            column(FA_Location_Code; "FA Location Code")
            {
            }
            column(AssetTypeFilter; AssetTypeFilter)
            {
            }
            column(AccDepn; abs(AccDepn))
            {
            }
            column(ActualDepreciation; ActualDepreciation)
            {
            }
            dataitem(FADepreciation; "FA Depreciation Book")
            {
                DataItemLink = "FA No." = field("No.");

                column(DepreciationStartingDate_FADepreciation; "Depreciation Starting Date")
                {
                }
                column(NoofDepreciationYears_FADepreciation; "No. of Depreciation Years")
                {
                }
                column(Acquisition_Date; "Acquisition Date")
                {
                }
                column(Acquisition_Cost; "Acquisition Cost")
                {
                }
                column(Book_Value; "Book Value")
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                FALedger: Record "FA Ledger Entry";
                FALedger2: Record "FA Ledger Entry";
            begin
                Clear(AccDepn);
                Clear(ActualDepreciation);
                FALedger.Reset();
                FALedger.SetRange("FA No.", FixedAsset."No.");
                FALedger.SetFilter("FA Posting Type", '%1', FALedger."FA Posting Type"::Depreciation);
                if FALedger.FindSet() then
                    repeat
                        AccDepn := AccDepn + FALedger.Amount;
                    until FALedger.Next() = 0;
                FALedger2.Reset();
                FALedger2.SetRange("FA No.", FixedAsset."No.");
                FALedger2.SetFilter("FA Posting Type", '%1', FALedger."FA Posting Type"::Depreciation);
                FALedger2.SetRange("Posting Date", FilterDate);
                if FALedger2.FindFirst() then ActualDepreciation := FALedger2.Amount;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                AssetTypeFilter := FixedAsset.GetFilter("FA Subclass Code");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(FilterDate; FilterDate)
                    {
                        Caption = 'Depr. Date';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        FilterDate: Date;
        AssetTypeFilter: Text;
        AccDepn: Decimal;
        ActualDepreciation: Decimal;
}
