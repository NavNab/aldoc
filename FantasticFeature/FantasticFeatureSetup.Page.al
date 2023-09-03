page 50101 "Fantastic Feature Setup"
{
    Caption = 'Fantastic Feature Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Fantastic Feature Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    ToolTip = 'This field enable or disable this feature.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}