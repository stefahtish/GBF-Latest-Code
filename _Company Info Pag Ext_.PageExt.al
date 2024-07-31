pageextension 50101 "Company Info Pag Ext" extends "Company Information"
{
    layout
    {
        modify("Bank Name")
        {
            Visible = true;
        }
        addlast(General)
        {
            field("Document Path"; Rec."Document Path")
            {
                ApplicationArea = All;
            }
            field("Online Document Path"; Rec."Online Document Path")
            {
                ApplicationArea = All;
            }
        }
        addafter("User Experience")
        {
            group("E-Mail Settings")
            {
                field("E-Mail Signature"; EmailSignText)
                {
                    MultiLine = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("E-Mail Signature");
                        rec."E-Mail Signature".CreateInStream(InStr);
                        EmailSignBigText.Read(InStr);
                        if EmailSignText <> Format(EmailSignBigText) then begin
                            Clear(Rec."E-Mail Signature");
                            Clear(EmailSignBigText);
                            EmailSignBigText.AddText(EmailSignText);
                            rec."E-Mail Signature".CreateOutStream(OutStr);
                            EmailSignBigText.Write(OutStr);
                        end;
                    end;
                }
            }
            group(Sharepoint)
            {
                field("Save to Sharepoint"; Rec."Save to Sharepoint")
                {
                    ApplicationArea = All;
                }
                field("Sharepoint URL"; Rec."Sharepoint URL")
                {
                    ApplicationArea = All;
                }
                field("Sharepoint Username"; Rec."Sharepoint Username")
                {
                    ApplicationArea = All;
                }
                field("Sharepoint Password"; Rec."Sharepoint Password")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                }
                field("Sharepoint Domain"; Rec."Sharepoint Domain")
                {
                    ApplicationArea = All;
                }
                field("Sharepoint Library"; Rec."Sharepoint Library")
                {
                    ApplicationArea = All;
                }
                field("Sharepoint Folder"; Rec."Sharepoint Folder")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Bank Account No.")
        {
            field("Bank Branch Name"; Rec."Bank Branch Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Branch Name field.';
            }
            field("Bank Account No.2"; Rec."Bank Account No.2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Account No. (KES) field.';
            }
            field("Bank Account No.3"; Rec."Bank Account No.3")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Account No. (USD) field.';
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("E-Mail Signature");
        rec."E-Mail Signature".CreateInStream(InStr);
        EmailSignBigText.Read(InStr);
        EmailSignText := Format(EmailSignBigText);
    end;

    var
        EmailSignBigText: BigText;
        EmailSignText: Text;
        InStr: InStream;
        OutStr: OutStream;
}
