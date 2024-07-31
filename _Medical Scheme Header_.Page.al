page 50481 "Medical Scheme Header"
{
    PageType = Card;
    SourceTable = "Medical Scheme Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Cover Type"; Rec."Cover Type")
                {
                }
                field("Cover Selected"; Rec."Cover Selected")
                {
                }
                field("Entitlement -Inpatient"; Rec."Entitlement -Inpatient")
                {
                    Editable = false;
                }
                field("Out-Patient Claims"; Rec."Out-Patient Claims")
                {
                    Caption = 'Medical Expenditure';
                    Editable = false;
                }
                field("Policy Start Date"; Rec."Policy Start Date")
                {
                }
                field("Policy Expiry Date"; Rec."Policy Expiry Date")
                {
                    Editable = false;
                }
                field("Entitlement -OutPatient"; Rec."Entitlement -OutPatient")
                {
                    Editable = false;
                }
                field("""Entitlement -OutPatient""-""Out-Patient Claims"""; Rec."Entitlement -OutPatient" - Rec."Out-Patient Claims")
                {
                    Caption = 'Balance';
                    Editable = false;
                }
            }
            part(Control13; "Medical Dependants")
            {
                SubPageLink = "Employee Code" = FIELD("Employee No"), "Medical Scheme No" = FIELD("No.");
            }
        }
    }
    actions
    {
    }
}
