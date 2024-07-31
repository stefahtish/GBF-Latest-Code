pageextension 50135 FixedAssetExt extends "Fixed Asset List"
{
    layout
    {
        addafter("Responsible Employee")
        {
            field(NetBookValue; BookValue)
            {
                Caption = 'Book Value';
                ApplicationArea = All;
            }
            field("Asset Condition"; Rec."Asset Condition")
            {
                ApplicationArea = all;
            }
            field("Vehicle Type"; Rec."Vehicle Type")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("Fixed Assets List")
        {
            action(ActionName)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Assets Register';
                Image = "Report2";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Asset Register";
                ToolTip = 'View the list of fixed assets that exist in the system .';
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        LoadFADepreciationBooks();
        CurrPage.Update(false);
        FADepreciationBook.Copy(FADepreciationBookOld);
        BookValue := GetBookValue();
    end;

    var
        BookValue: Decimal;
        FADepreciationBook: Record "FA Depreciation Book";
        FADepreciationBookOld: Record "FA Depreciation Book";

    local procedure GetBookValue(): Decimal
    begin
        if FADepreciationBook."Disposal Date" > 0D then exit(0);
        exit(FADepreciationBook."Book Value");
    end;

    protected procedure LoadFADepreciationBooks()
    begin
        Clear(FADepreciationBookOld);
        FADepreciationBookOld.SetRange("FA No.", Rec."No.");
        if FADepreciationBookOld.Count <= 1 then begin
            if FADepreciationBookOld.FindFirst then FADepreciationBookOld.CalcFields("Book Value");
        end;
    end;
}
